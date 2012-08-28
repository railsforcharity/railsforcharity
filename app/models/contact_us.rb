class ContactUs

  include ActiveModel::Validations

  validates :name, :presence => true
  validates :email, :presence => true,
    :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "email is invalid" }
  validates :description, :presence => true,
    :length => {:minimum => 10}

  # to deal with form, you must have an id attribute
  attr_accessor :id, :name, :email, :description

  def initialize(attributes = {})
    attributes.each do |key, value|
      self.send("#{key}=", value)
    end
    @attributes = attributes
  end

  def read_attribute_for_validation(key)
    @attributes[key]
  end

  def to_key;
  end

  def save
    if self.valid?
      Emails.contact_us(self).deliver
      return true
    end
    return false
  end

  def persisted?
    false
  end

end
