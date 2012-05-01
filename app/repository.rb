##
# This is the entry point class for all Persistence related logic.
# The application needs to configure how Domain models are mapped to the
# appropriate Persistence implementations.
#
# Then, when the application needs to persist a model, it finds the appropriate
# repository for the model using +.for+ and calls the API as defined in the
# mapped repository class.
##
class Repository

  ##
  # Add a mapping to this repository. This will add to the existing known
  # set of mappings. To start the mapping list anew, use +.reset!+ first.
  ##
  def self.configure(options = {})
    @mappings ||= {}
    @mappings.merge!(options)
  end

  ##
  # Clear out all known mappings
  ##
  def self.reset!
    @mappings = {}
  end

  ##
  # Find the defined mapping for the given Domain Model class
  ##
  def self.for(klass)
    @mappings[klass] || @mappings[klass.to_s]
  end

end