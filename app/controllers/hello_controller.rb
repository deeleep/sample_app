class HelloController < ApplicationController
    def hello
        render "hello/index"
    end
end