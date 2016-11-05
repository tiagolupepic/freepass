require './config/boot'
require "rails_erd/diagram/graphviz"

RailsERD.options.orientation = :vertical
RailsERD::Diagram::Graphviz.create
