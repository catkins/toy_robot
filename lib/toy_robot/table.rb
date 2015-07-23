module ToyRobot
  class Table
    include Virtus.model

    attribute :width,  Integer
    attribute :height, Integer

    attr_reader :obstructions

    def initialize(*args)
      super(*args)
      @obstructions = Set.new
    end

    def position_is_vacant?(point)
      inside_bounds?(point) && !obstruction_at?(point)
    end

    def valid?
      width > 0 && height > 0
    end

    def place_object!(point)
      @obstructions << point if inside_bounds? point
    end

    private

    def inside_bounds?(point)
      x_bounds.include?(point.x) && y_bounds.include?(point.y)
    end

    def obstruction_at?(point)
      @obstructions.include? point
    end

    def x_bounds
      0..(width - 1)
    end

    def y_bounds
      0..(height - 1)
    end
  end
end
