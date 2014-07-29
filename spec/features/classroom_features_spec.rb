# As a user (student or teacher)
# I want to log into my classroom

  # As a student logged into my classroom (these tests are within the confines of the classroom resource)

    # I should see
      # A box to go to my student overview
      # My classes
      # My pending assignments
        # sorted by closest due date to today

    # I should be able to
      # Add a new class that I am enrolled in
      # Go to my student overview analytics page
      # Click on a class and go to that classroom

        # I should see
        # Active assignments
          # When I click on an active assignment
            # I should go to that active assignment
        # Past assignments
          # When I click on an active assignment
            # I should go to that past assignment

  # As a teacher logged into my classroom (these tests are within the confines of the classroom resource)

    # I should see
      # My classes
      # My pending assignments
        # sorted by closest due date
      # The classroom invitation code at the bottom of the page

    # I should be able to
      # Click on a class and go to that classroom
        # I should see

          # A button to create a new assignment
            # I can click on create new assignment
              # It goes to a page (outside classroom resource(/assignment/new/?classroom_id=:id)) to allow teacher to create a new assignment

          # A class roster for that classroom
            # I can click on a student
              # It goes to a page (outside classroom resource (/users/:id)) to see user data and submissions for a classroom

          # Pending assignments for that class
            # sorted by closest due date to today
              # I can click on an assignment and it goes to a page (outside classroom resource(assignment/:id))
                # On this page I can see the classroom(back to classroom resource)
                # the assignment title and prompt
                # the students, level, and assignment status as a link that currently goes nowhere
                # an edit assignment button that goes to another page (outside classroom resource(assignment/:id/edit?classroom_id=:id)

          # Past assignments for that class
            # sorted by closest to date today
              # I can click on a past assignment and it goes to a page (outside classroom resource(assignment/:id))
                # On this page I can see the classroom(back to classroom resource)
                # the assignment title and prompt
                # the students, level, and assignment status as a link that currently goes nowhere
                # an edit assignment button that goes to another page (outside classroom resource(assignment/:id/edit?classroom_id=:id)

        # Click on a pending assignment
          # It should go to a page showing that assignment with the students it was assigned to (redirect outside of classroom resource)












