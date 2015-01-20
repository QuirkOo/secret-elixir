defmodule ContactTest do
  use ExUnit.Case, async: true

  alias AddressBook.Contact, as: Contact
  alias AddressBook.Name, as: Name

  test "creating a contact" do
  	assert Contact.new == %Contact{}
  end

  test "creating a name" do
    assert Name.new("John", "Doe") == %Name{firstName: "John", lastName: "Doe"}
  end
end
