class CoffeeType
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :location, type: String

  belongs_to :roaster
  has_many :rankings

  def maps_url
    map_location = MapLocation.new(:address => location)
    map = GoogleStaticMap.new(
      :zoom => 7,
      :maptype => "hybrid",
      :center => map_location,
      :format => "gif"
    )
    map.markers << MapMarker.new(:color => "red", :location => map_location)
    map.url(:auto)
  end

  def as_json options = {}
    super.merge(rankings: rankings, maps_url: maps_url)
  end

end
