class State < ActiveRecord::Base
  def self.uf!(uf)
    self.find_by!(uf: uf.to_s)
  end
end
