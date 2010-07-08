class Remix < ActiveRecord::Base
  
  include ActionView::Helpers::NumberHelper
  
  attr_accessor :file
  
  belongs_to :user
  has_many :votes
  
  validates_presence_of :title
  validates_presence_of :file
  
  cattr_reader :per_page
  @@per_page = 5
  
  def url
    "http://api.soundcloud.com/tracks/#{track_id}&color=#{SETTINGS['player_color']}&text_buy_track=Vote For My Remix"
  end
  
  def available?
    HTTParty.get("http://api.soundcloud.com/tracks/#{track_id}").code == 404 ? false : true
  end
  
  def voted?(ip_address)
    Vote.find(:first, :conditions => {:remix_id => id, :ip_address => ip_address}) ? true : false
  end
  
end
