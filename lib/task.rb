class Task < ActiveRecord::Base

  # after_initialize :init
  # def init
  #     self.done ||= false
  # end

  belongs_to(:list)

  scope(:not_done, -> do
    where({:done => nil})
  end)
end
