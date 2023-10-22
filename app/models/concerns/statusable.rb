module Statusable
  extend ActiveSupport::Concern

  included do
    STATUS_ACTIONS = { accept: :accept_vacation, reject: :reject_vacation  }

    include AASM

    enum status: { received: 0, accepted: 1, rejected: 2 }

    aasm column: :status, enum: true do
      state :received, initial: true
      state :accepted, :rejected
  
      event :accept_vacation do
        transitions from: :received, to: :accepted
      end
  
      event :reject_vacation do
        transitions from: :received, to: :rejected
      end
    end
  
    def change_status(status_action)
      self.aasm.send(:fire!, STATUS_ACTIONS[status_action.to_sym])
      # send email
    end
  end
end
