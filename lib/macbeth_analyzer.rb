require 'hurley'
require 'pry'
require 'active_support/core_ext/hash'

class MacbethAnalyzer

  attr_reader :macbeth_hash

  def count_lines_by_speaker(play)
  end

  def count_lines_in_scene(scene)
    scene.inject(Hash.new(0)) do |counter, line|
      speaker = line["SPEAKER"].capitalize
      counter[speaker] += 1
      counter
    end
  end

  def fetch_macbeth
    macbeth = Hurley.get("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml")
    @macbeth_hash = Hash.from_xml(macbeth.body)
  end
end
