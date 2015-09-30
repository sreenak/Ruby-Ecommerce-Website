class ShipmentsController < ApplicationController
  # require 'rubygems'
  # require 'aftership'
  def show
    # AfterShip::V4::Courier.get
    # AfterShip::V4::Courier.get_all
    @track_details = AfterShip::V4::Courier.detect({:tracking_number => '1Z31Y1Y90490064644'})
    @asd = AfterShip::V4::Tracking.get('ups', '1Z31Y1Y90490064644')
  end
end
