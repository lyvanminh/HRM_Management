class Api::V1::CandidatesController < Api::V1::ApiController

  def index
    candidates = Candidate.get_all

    render_all_data_success candidates, seach_serializer: CandidateSerializer
  end

  def create
    ActiveRecord::Base.transaction do
      candidate = Candidate.create!(candidate_params)

      render_success candidate, serializer: CandidateSerializer
    end
  end

  def update
    ActiveRecord::Base.transaction do
      @candidate.update!(status: params[:status])

      render_success @candidate, serializer: CandidateSerializer
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

    content_cv = content_cv.join(", ").gsub(" ", "").downcase
    positions = Position.get_all.select { |p| content_cv.include?(p.position.gsub(" ", "").downcase) }
    languages = Language.get_all.select { |l| content_cv.include?(l.language.gsub(" ", "").downcase) }
    levels = Level.get_all.select { |lv| content_cv.include?(lv.level.gsub(" ", "").downcase) }

    json = {
      success: true,
      result: {
        user_name: user_name,
        address: address,
        birth_day: birth_day,
        email: gmail,
        position_id: positions[0]&.id,
        language_id: languages[-1]&.id,
        level_id: levels[-1]&.id
      }.as_json
    }

    File.delete(full_path)

    render json: json
  end

  private

  def find_candidate
    @candidate = Candidate.find_by!(id: params[:id])
  end

  def candidate_params
    params.permit(:user_name, :birth_day, :email, :phone, :address, :chanel_id, :level_id,
                  :language_id, :position_id, :user_refferal_id, :content_cv, :url_cv)
  end
end
