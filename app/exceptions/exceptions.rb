module Exceptions
  IDS = {
    Default: 1000,
    AuthenticationError: 1001,
    MissingParamsError: 1002,
    InvalidParamsError: 1003,
    ConfirmationError: 1004
  }

  class CustomException < StandardError
    attr_reader :object

    def initialize(object = nil)
      @object = object
    end

    def message
      I18n.t("exceptions.#{self.class.name.demodulize}")
    end
  end

  class ParamsException < StandardError
    attr_reader :options

    def initialize(**options)
      @options = options
    end

    def message
      I18n.t("exceptions.errors.#{options[:error]}")
    end
  end

  class CustomValidate < StandardError
    attr_reader :model, :error

    def initialize(model, error)
      @model = model
      @error = error
    end

    def message
      I18n.t("errors.#{model.class.name.downcase.pluralize}.#{error}")
    end
  end

  class AuthenticationError < CustomException; end

  class MissingParamsError < ParamsException; end

  class InvalidParamsError < ParamsException; end

  class ConfirmationError < CustomException; end

  def to_json exception
    Rails.logger.error exception.class
    Rails.logger.error exception.message
    st = exception.backtrace.join("\n")
    Rails.logger.error st

    case exception
      # Rails exceptions
    when ActiveRecord::RecordNotFound
      {
        status: 404,
        error: {
          id: 404,
          message: exception.message
        }
      }
    when ActiveRecord::RecordInvalid
      {
        status: 400,
        error: {
          id: 400,
          message: exception.message,
          details: exception.record.errors.messages
        }
      }
    when Doorkeeper::Errors::TokenExpired, Doorkeeper::Errors::TokenUnknown,
      Doorkeeper::Errors::TokenForbidden, Doorkeeper::Errors::TokenRevoked,
      AuthenticationError
      {
        status: 401,
        error: {
          id: 401,
          message: exception.message
        }
      }
    when CustomException
      {
        status: 400,
        error: {
          id: IDS[exception.class.name.demodulize.to_sym],
          message: exception.message
        }
      }
    when ParamsException
      {
        status: 400,
        error: {

          id: IDS[exception.class.name.demodulize.to_sym],
          message: exception.message
        }
      }
    else
      {
        status: 499,
        error: {
          id: IDS[:Default],
          message: exception.message
        }
      }
    end
  end

  module_function :to_json
end
