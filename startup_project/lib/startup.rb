require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees
    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end
    def valid_title?(title)
        @salaries.has_key?(title)
    end
    def >(other_startup)
        self.funding > other_startup.funding
    end
    def hire(name,title)
        if self.valid_title?(title)
           @employees << Employee.new(name,title)
        else
            raise 'title is invalid!'
        end
    end
    def size
        @employees.length
    end
    def pay_employee(employee)
        if @funding >= @salaries[employee.title]
            employee.pay(@salaries[employee.title])
            @funding -= @salaries[employee.title]
        else
            raise 'not enough funding!'
        end
    end
    def payday
        @employees.each do |employee|
            self.pay_employee(employee)
        end
    end
    def average_salary
        sum = 0
        @employees.each do |employee|
           sum += @salaries[employee.title]
        end
        sum / (employees.length*1.0)
    end
    def close
        @employees = []
        @funding = 0
    end
    def acquire(startup)
        @funding += startup.funding
        startup.salaries.each do |title,aqSalary|
            if !@salaries.has_key?(title)
                @salaries[title] = aqSalary
            end
        end
        @employees += startup.employees
        startup.close()
    end
end
