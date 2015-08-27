class ShipmentsController < ApplicationController
  # require 'rubygems'
  # require 'aftership'
  def show
    @track_details = AfterShip::V4::Courier.detect({:tracking_number => 'EJ276142450JP'})
  end
end
