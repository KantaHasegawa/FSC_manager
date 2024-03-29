# frozen_string_literal: true

class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :band, optional: true
  belongs_to :relationship, optional: true
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id'
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id'
end
