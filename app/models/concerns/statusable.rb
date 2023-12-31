module Statusable
  extend ActiveSupport::Concern

  included do
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
      aasm.send(:fire!, Vacation::STATUS_ACTIONS[status_action.to_sym])
      # send email
    end
  end
end
