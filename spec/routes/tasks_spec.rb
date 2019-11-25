require 'rails_helper'

RSpec.describe "posts", type: :routing do
  it "#index" do
    expect(get: "/tasks").to route_to("tasks#index")
  end

  it "#show" do
    expect(get: "/tasks/1").to route_to("tasks#show", id: "1")
  end

  it "#new" do
    expect(get: "/tasks/new").to route_to("tasks#new")
  end

  it "#edit" do
    expect(get: "/tasks/1/edit").to route_to("tasks#edit", id: "1")
  end

  it "#create" do
    expect(post: "/tasks").to route_to("tasks#create")
  end

  it "#update" do
    expect(put: "/tasks/1").to route_to("tasks#update", id: "1")
  end

  it "#destroy" do
    expect(delete: "/tasks/1").to route_to("tasks#destroy", id: "1")
  end

  it "root" do
    expect(get: "/").to route_to("tasks#index")
  end

  it "search" do
    expect(get: "/tasks/search").to route_to("tasks#search")
  end
end