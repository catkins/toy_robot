module ToyRobot

  class Table

    include Virtus.value_object

    values do
      attribute :width,  Integer
      attribute :height, Integer
    end

    def inside_bounds?(x, y)
      x_bounds.include?(x) && y_bounds.include?(y)
    end

    def valid?
      width > 0 && height > 0
    end

    private

    def x_bounds
      0..(width - 1)
    end

    def y_bounds
      0..(height - 1)
    end
  end

end
