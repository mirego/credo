defmodule Credo.Code.CharlistsTest do
  use Credo.TestHelper

  alias Credo.Code.Charlists

  test "it should return the source without string literals 2" do
    source = """
    x = "this 'should not be' removed!"
    y = 'also: # TODO: no comment here'
    ?' # TODO: this is the third
    # '

    \"\"\"
    y = 'also: # TODO: no comment here'
    \"\"\"

    'also: # TODO: no comment here as well'
    """

    expected = """
    x = "this 'should not be' removed!"
    y = '                             '
    ?' # TODO: this is the third
    # '

    \"\"\"
    y = 'also: # TODO: no comment here'
    \"\"\"

    '                                     '
    """

    assert expected == source |> Charlists.replace_with_spaces()
  end

  test "it should not modify commented out code" do
    source = """
    defmodule Foo do
      defmodule Bar do
        # @doc \"\"\"
        # Reassign a student to a discussion group.
        # This will un-assign student from the current discussion group
        # \"\"\"
        # def assign_group(leader = %User{}, student = %User{}) do
        #   cond do
        #     leader.role == :student ->
        #       {:error, :invalid}
        #
        #     student.role != :student ->
        #       {:error, :invalid}
        #
        #     true ->
        #       Repo.transaction(fn ->
        #         {:ok, _} = unassign_group(student)
        #
        #         %Group{}
        #         |> Group.changeset(%{})
        #         |> put_assoc(:leader, leader)
        #         |> put_assoc(:student, student)
        #         |> Repo.insert!()
        #       end)
        #   end
        # end
        def baz, do: 123
      end
    end
    """

    expected = source

    assert expected == source |> Charlists.replace_with_spaces(".")
  end
end
