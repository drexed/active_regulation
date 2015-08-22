class User < ActiveRecord::Base

  include ActiveRegulation::Activation
  include ActiveRegulation::Containment
  include ActiveRegulation::Expiration
  include ActiveRegulation::Visibility

end