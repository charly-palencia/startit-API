class ModelServiceBaseService

  def build_object(&action)
    begin
      action.call
    rescue ActiveModel::ValidationError, ActiveRecord::RecordInvalid => e
      record_errors = e.record.errors
      if e.record.is_a? Form
        record_errors.to_h.each do |field, error|
          errors.add!(:form, error)
        end
      else
        errors.merge!(record_errors)
      end
      return false
    end
  end
end
