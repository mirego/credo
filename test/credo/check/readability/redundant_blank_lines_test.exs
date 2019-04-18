defmodule Credo.Check.Readability.RedundantBlankLinesTest do
  use Credo.TestHelper

  @described_check Credo.Check.Readability.RedundantBlankLines

  #
  # cases NOT raising issues
  #

  test "it should NOT report expected code" do
    """
    defmodule ModuleWithoutRedundantBlankLines do
      def a do
        1
      end

      def b do
        2
      end
    end
    """
    |> to_source_file
    |> refute_issues(@described_check)
  end

  test "it should NOT report heredocs" do
    """
    defmodule ModuleWithoutRedundantBlankLines do
      def a do
        \"\"\"
        This is a heredoc (multi-line string)


        ---




        White Space seems intentional here.
        \"\"\"
      end

      def b do
        2
      end
    end
    """
    |> to_source_file
    |> refute_issues(@described_check)
  end

  test "it should not fail when file doesn't have empty lines" do
    "defmodule ModuleWithoutEmptyLines do
  def foo do
    :bar
  end
end"
    |> to_source_file
    |> refute_issues(@described_check)
  end

  #
  # cases raising issues
  #

  test "it should report a violation" do
    """
    defmodule ModuleWithRedundantBlankLines do
      def a do
        1
      end


      def b do
        1
      end
    end
    """
    |> to_source_file
    |> assert_issue(@described_check)
  end

  test "it should be relative max_blank_lines param" do
    file =
      """
      defmodule ModuleWithManyBlankLines do
        def a do
          1
        end




        def b do
          1
        end
      end
      """
      |> to_source_file

    file
    |> refute_issues(@described_check, max_blank_lines: 4)

    file
    |> assert_issue(@described_check, max_blank_lines: 3)
  end
end
