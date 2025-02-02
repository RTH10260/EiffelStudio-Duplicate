note
	description: "Objects that represent EV_TEXT_COMPONENT_ACTION_SEQUENCES."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_TEXT_COMPONENT_ACTION_SEQUENCES

inherit
	GB_EV_ACTION_SEQUENCES
		redefine
			action_sequence_type_name, has_name, name
		end

feature -- Status Report

	has_name (a_feature_name: STRING): BOOLEAN
		do
			Result := a_feature_name.same_string (change_actions_name) or
				a_feature_name.same_string (text_change_actions_name)
		end

feature -- Access

	action_sequence_type_name (a_feature_name: STRING_8): STRING_8
			-- <Precursor>
			--| Special implementation to handle renaming of `change_actions' into `text_change_actions' in EV_SPIN_BUTTON.
		do
				-- It is the same action sequence regardless of the name
			Result := types.first
		end

	name (a_type: STRING; an_index: INTEGER): STRING
			--| Special implementation to handle renaming of `change_actions' into `text_change_actions' in EV_SPIN_BUTTON.	
		do
			if a_type.same_string ({GB_CONSTANTS}.ev_spin_button_string) then
				Result := text_change_actions_name
			else
				Result := change_actions_name
			end
		end

	types: ARRAYED_LIST [STRING]
			-- All types of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("EV_NOTIFY_ACTION_SEQUENCE")
		end

	comments: ARRAYED_LIST [STRING]
			-- All comments of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("-- Actions to be performed when `text' changes.")
		end

	connect_event_output_agent (object: EV_ANY; action_sequence: STRING; adding: BOOLEAN; string_handler: ORDERED_STRING_HANDLER)
			-- If `adding', then connect an agent to `action_sequence' actions of `object' which will display name of
			-- action sequence and all arguments in `string_handler'. If no `adding' then `remove_only_added' `action_sequence'.
		local
			notify_sequence: GB_EV_NOTIFY_ACTION_SEQUENCE
			text_component: EV_TEXT_COMPONENT
			spin_button: EV_SPIN_BUTTON
		do
			text_component ?= object
			check
				text_component_not_void: text_component /= Void
			end
			if action_sequence.same_string (change_actions_name) then
				if adding then
					spin_button ?= text_component
					notify_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_NOTIFY_ACTION_SEQUENCE"))
					if spin_button /= Void then
						spin_button.text_change_actions.extend (notify_sequence.display_agent (text_change_actions_name, string_handler))
					else
						text_component.change_actions.extend (notify_sequence.display_agent (action_sequence, string_handler))
					end
				else
					spin_button ?= text_component
					if spin_button /= Void then
						remove_only_added (spin_button.text_change_actions)
					else
						remove_only_added (text_component.change_actions)
					end
				end
			end
		end

feature {NONE} -- Implementation

	names: ARRAYED_LIST [STRING]
			-- All names of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend (change_actions_name)
			Result.compare_objects
		end

	change_actions_name: STRING = "change_actions"
	text_change_actions_name: STRING = "text_change_actions"

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_EV_TEXT_COMPONENT_ACTION_SEQUENCES
