module ToyRobot
  class Point
    include Virtus.value_object
    include Adamantium

    values do
      attribute :x, Integer
      attribute :y, Integer
    end

  end
end
