defmodule AddressBook.Contact do
	defstruct phones: HashSet.new, emails: HashSet.new

	def updatePhones(c, phone) do
		%AddressBook.Contact{c | phones: HashSet.put(c.phones, phone)}
	end

	def updateEmails(c, email) do
		%AddressBook.Contact{c | emails: HashSet.put(c.emails, email)}
	end

	def new() do
		%AddressBook.Contact{}
	end

end

defmodule AddressBook.Name do
	defstruct firstName: "", lastName: ""

	def new(firstName, lastName) do
		%AddressBook.Name{firstName: firstName, lastName: lastName}	end
end

