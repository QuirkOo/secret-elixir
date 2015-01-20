defmodule AddressBook do
	@moduledoc """
	Stores contacts with lists of phones and names.		
	"""
	alias AddressBook.Contact, as: Contact
	alias AddressBook.Name, as: Name

	@doc """ 
	Starts a new address book 
	"""
	def start_link do
		Agent.start_link(&HashDict.new/0, [name: :ab_server])
	end

	@doc """
	Adds a new contact.
	"""
	def addContact(firstName, lastName) do
		name = Name.new(firstName, lastName)
		Agent.update(:ab_server, &HashDict.put_new(&1, name, Contact.new))
	end
	
	@doc """
	Updates existing contact.
	"""
	def updatePhone(firstName, lastName, phone) do
		name = Name.new(firstName, lastName)
		Agent.update(:ab_server, &HashDict.update!(&1, name, fn c -> Contact.updatePhones(c, phone) end))
	end

	@doc """
	Updates existing contact.
	"""
	def updateEmail(firstName, lastName, email) do
		name = Name.new(firstName, lastName)
		Agent.update(:ab_server, &HashDict.update!(&1, name, fn c -> Contact.updateEmails(c, email) end))
	end

	@doc """
	Retrieves contact by name
	"""
	def getContact(firstName, lastName) do
		name = Name.new(firstName, lastName)
		Agent.get(:ab_server, &HashDict.fetch(&1, name))
	end
end
