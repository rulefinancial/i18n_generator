# encoding: utf-8

class Label
  def initialize(params_hash)
    validate_params(params_hash)

    params_hash.each do |param, value|
      instance_variable_set("@#{param}", value)

      define_singleton_method param.to_sym do
        instance_variable_get("@#{param}")
      end
    end
  end

  def validate_params(params)
    %w(id en).map(&:to_sym).each do |req_param|
      raise "Label is missing required parameter [#{req_param}]" unless params[req_param] && !params[req_param].empty?
    end
  end
end