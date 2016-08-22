module ErrorSerializer
  def self.serialize(object)
    errors = object.errors.messages.map do |field, errors|
      errors.map do |error_message|
        {
          code: "VALIDATION_ERROR",
          message: "#{field.to_s.camelcase} #{error_message}",
          invalid_field: field,
          status: 422
        }
      end
    end
    { errors: errors.flatten }
  end

  def self.serialize_not_found(message = "")
    default_message = "Record not found"
    error_message = message.present? ? "#{default_message}: #{message}" : default_message
    error_template("RECORD_NOT_FOUND", 404, error_message)
  end

  def self.bad_request(message)
    error_template("BAD_REQUEST", 400, message)
  end

  def self.request_not_acceptable
    error_template("REQUEST_NOT_ACCEPTABLE", 406, "")
  end

  private

  def self.error_template(code, status, message)
    {
      errors: [
        {
          code: code,
          status: status,
          message: message
        }
      ]
    }
  end

end
