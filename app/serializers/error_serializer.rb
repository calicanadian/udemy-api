class ErrorSerializer
  def initialize(error)
    @error = error
  end

  def to_h
    serializeable_hash
  end

  def to_json(payload)
    to_h.to_json
  end

  private

  def serializeable_hash
    {
      errors: Array.wrap(error.serializeable_hash).flatten
    }
  end

  attr_reader :error
end
