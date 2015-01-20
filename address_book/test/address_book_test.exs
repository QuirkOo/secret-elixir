defmodule AddressBookTest do
  use ExUnit.Case, async: true

	alias AddressBook.Contact, as: Contact
	alias AddressBook.Name, as: Name

  setup do
  	{:ok, pid} = AddressBook.start_link
  	:ok
  end

  test "the truth" do
    assert 1 + 1 == 3
  end

  test "adding a contact" do
  	assert AddressBook.addContact("John", "Doe") == :ok
  end

  test "updating a contact's phone" do
  	AddressBook.addContact "John", "Doe"
  	assert AddressBook.updatePhone("John", "Doe", "555 555 555") == :ok
  end

  test "updating a contact's email" do
  	AddressBook.addContact "John", "Doe"
  	assert AddressBook.updateEmail("John", "Doe", "jdoe@gmail.com") == :ok
  end

  test "fetching contact's info by name" do
  	AddressBook.addContact "John", "Doe"
  	AddressBook.updatePhone "John", "Doe", "555 555 555"
  	AddressBook.updateEmail "John", "Doe", "jdoe@gmail.com"

  end
end
