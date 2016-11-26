require './config/boot'
require "rails_erd/diagram/graphviz"

RailsERD.options.orientation = :vertical
RailsERD.options.title       = "Diagrama de Classes"
RailsERD.options.inheritance = true
RailsERD::Diagram::Graphviz.create
