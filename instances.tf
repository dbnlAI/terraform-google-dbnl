locals {
  instance_types = tomap({
    small = {
      # TODO(ENG-553) not certain how these values scale / are priced
      database = {
        tier = "db-custom-1-3840"
        size = "10" # GB
      }
      kubernetes = "n2-standard-2"
      redis      = "8" # GB
    }
    medium = {
      database = {
        tier = "db-custom-4-15360"
        size = "50" # GB
      }
      kubernetes = "n2-standard-8"
      redis      = "20" # GB
    }
  })
}
