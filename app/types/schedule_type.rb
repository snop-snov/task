class ScheduleType < ActiveType::Object
  include Authority::Abilities

  CONTENT_TYPE = 'text/csv'.freeze

  attribute :file, :file

  validates :file, presence: true
  validate :check_content_type, if: :file

  private

  def check_content_type
    unless file.content_type == CONTENT_TYPE
      errors.add(:file, :wrong_content_type)
    end
  end
end
