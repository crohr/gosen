require 'gosen/model'
require 'json'

module Gosen
  class Reservation
    include Model
    attr_accessor :state, :queue, :raw_job_id, :start_time, :user, :walltime
  end
end
