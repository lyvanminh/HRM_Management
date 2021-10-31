# Create data table users
User.delete_all
10.times do |i|
  User.create!(email: "test_email+#{role.id}@asia.com",
               name: Faker::Name.name,
               phone_number: "0336896191",
               birthday: Faker::Date.between(from: 40.years.ago, to: 20.years.ago),
               password: "12345678")
end

# Create data table languages
Language.delete_all
languages = ["Ruby", "PHP", "Golang", "Python", "React Native", "React JS", "Vuejs", "Nodejs"]
arr = []
languages.each do |language|
  arr << {
    language: language,
    description: Faker::Lorem.paragraphs[0]
  }
end
Language.import arr, validate: true

# Create data table levels
Level.delete_all
levels = ["Intern", "Fresher", "Junior", "Middle", "Senior", "Leader", "Brse", "Comtor", "Manager", "Freelancer"]
arr = []
levels.each do |level|
  arr << {
    level: level,
    description: Faker::Lorem.paragraphs[0]
  }
end
Level.import arr, validate: true

# Create data table positions
Position.delete_all
positions = ["Web Developer", "Mobile Developer", "HR Recruitment", "Backend Developer", "Frontend Developer", "Fullstack Developer"]
arr = []
positions.each do |position|
  arr << {
    position: position,
    description: Faker::Lorem.paragraphs[0]
  }
end
Position.import arr, validate: true

# Create data table chanels
Chanel.delete_all
chanels = ["Top CV", "IT Viec", "Kirara Suport", "Indeed", "Lindked", "Facebook"]
arr = []
chanels.each do |chanel|
  arr << {
    chanel_name: chanel,
  }
end
Chanel.import arr, validate: true

# Create data table recruitments
Recruitment.delete_all
ceo = User.find_by(role: 8)
level_ids = Level.all.pluck(:id)
language_ids = Language.all.pluck(:id)
position_ids = Position.all.pluck(:id)
5.times do |i|
  Recruitment.create!(level_id: level_ids.sample, language_id: language_ids.sample, position_id: position_ids.sample, receive_user_id: ceo.id)
end

# Create data table requests (recruitment requests)
Request.delete_all
recruitments = Recruitment.all
hr_department = User.find_by(role: 0)
recruitments.each do |recruitment|
  Request.create!(sender_id: hr_department.id,
                  requestable_id: recruitment.id,
                  requestable_type: "Recruitment")
end

# Create data table candidates
Candidate.delete_all
chanel_ids  = Chanel.all.pluck(:id)
level_ids = Level.all.pluck(:id)
language_ids = Language.all.pluck(:id)
position_ids = Position.all.pluck(:id)
user_ids = User.all.pluck(:id)
file = File.open("app/assets/images/example_cv.docx.pdf")
10.times do |i|
  Candidate.create!(user_name: Faker::Name,
                    birth_day: Faker::Date.between(from: 40.years.ago, to: 20.years.ago),
                    email: Faker::Internet.email,
                    phone: Faker::PhoneNumber.subscriber_number(length: 11),
                    address: Faker::Address,
                    chanel_id: chanel_ids.sample,
                    level_id: level_ids.sample,
                    language_id: language_ids.sample,
                    position_id: position_ids.sample,
                    content_cv: file,
                    user_refferal_id: user_ids.sample,
                    url_cv: "https://www.lipsum.com/")
end

# Create criterias
Criterias.delete_all
contents = ["Evaluate for technical", "Evaluate for skill", "Evaluate for communicate", "Evaluate for attitude", "Evaluate other"]
4.times do |i|
  Criterias.create(
    criteria_type: i,
    content: contents[i]
  )
end

create interviews
Interview.delete_all
levels = Level.all
levels.each do |level|
  Interview.create(
    level_id: level.id,
    description: Faker::Lorem.paragraphs[0],
    name: level.level
  )
end

#create rounds
Round.delete_all
interviews = Interview.all
interviews.each do |interview|
  if interview.name == "Leader" || interview.name == "Brse" || interview.name == "Comtor" || interview.name == "Manager"
    2.times do |i|
      Round.create(interview_id: interview.id,
                   name: interview.name + "Interview Round #{i+1}",
                   description: Faker::Lorem.paragraphs[0],
                   order: i+1)
    end
  else
    Round.create(interview_id: interview.id,
                 name: interview.name + "Interview Round 1",
                 description: Faker::Lorem.paragraphs[0],
                 order: 1)
  end
end

#create interviewer
Interviewer.delete_all
interviews = Interview.all
interviews.each do |interview|
  if interview.name == "Junior" || interview.name == "Middle" || interview.name == "Senior"
    2.times do |i|
      a = ["project_manager", "technical_manager"]
      Interviewer.create(
        round_id: interview.rounds[0].id,
        role: a[i],
        amount: 1
      )
    end
  elsif interview.name == "Leader" || interview.name == "Brse"
    Interviewer.create(round_id: interview.rounds[0].id,
                       role: "ceo",
                       amount: 1
                      )
    if interview.name == "Leader"
      2.times do |i|
        a = ["project_manager", "hr_manager"]
        Interviewer.create(
          round_id: interview.rounds[1].id,
          role: a[i],
          amount: 1
        )
      end
    else
      Interviewer.create(round_id: interview.rounds[1].id,
                         role: "general_manager",
                         amount: 1
      )
    end
  elsif interview.name == "Manager"
    a = ["ceo", "hr_manager"]
    a.each_with_index do |b, i|
      Interviewer.create(round_id: interview.rounds[i].id,
                         role: b,
                         amount: 1
      )
    end

  elsif interview.name == "Freelancer"
    Interviewer.create(round_id: interview.rounds[0].id,
                       role: "customer",
                       amount: 1
    )
  end
end


