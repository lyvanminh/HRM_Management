class Api::V1::CandidatesController < Api::V1::ApiController

  def create
    ActiveRecord::Base.transaction do
      candidate = Candidate.create!(candidate_params)

      render_success candidate, serializer: CandidateSerializer
    end
  end

  def format_cv
    file = params[:file_cv]
    full_path = Rails.root.join('tmp', DateTime.now.strftime("%Y%m%d%H%M%S") + '_' + file.original_filename)
    File.open(full_path, 'w+b') do |fp|
      fp.write file.read
    end

    file_cv = PDF::Reader.new(full_path)
    content_cv = []
    file_cv.pages.each do |page|
      content_cv << page.text.gsub("\n", "  ").split("  ").select {|word| word != ""}
    end

    content_cv = content_cv.flatten
    user_name = content_cv[0]
    address = content_cv[1].gsub("Address: ", "")
    birth_day = content_cv[2].gsub("Date of birth: ", "").gsub("/", "-")
    gmail = content_cv[3].gsub("Gmail: ", "")

    json = {
      success: true,
      result: {
        user_name: user_name,
        address: address,
        birth_day: birth_day,
        gmail: gmail
      }.as_json
    }

    File.delete(full_path)

    render json: json
  end

  private

  def candidate_params
    params.permit(:user_name, :birth_day, :email, :phone, :address, :chanel_id, :level_id,
                  :language_id, :position_id, :content_cv, :user_refferal_id, :url_cv)
  end
end
