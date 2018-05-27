require "test/unit"
require "pathname"
require_relative "../../classes/file_opener"
require_relative "../../classes/lap"
require_relative "../../classes/race"

class FileOpenerSpec < Test::Unit::TestCase
  def test_initialize
    file_path = Pathname.new("spec/files/file.log")
    file = FileOpener.new(file_path)

    assert_equal(file.file_path, file_path)
  end

  def test_file_not_found
    file_path = Pathname.new("some/other/file.log")
    file = FileOpener.new(file_path)

    assert_raise(Errno::ENOENT) {
      file.get_race_from_file
    }
  end

  def test_get_race_from_file
    file_path = Pathname.new("spec/files/file.log")
    file = FileOpener.new(file_path)

    assert_match(/\d+/, file.get_race_from_file.to_s)
  end
end
