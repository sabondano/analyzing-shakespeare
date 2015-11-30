require 'hurley'
require 'pry'
require 'active_support/core_ext/hash'

class MacbethAnalyzer

  attr_reader :macbeth_hash

  def fetch_macbeth
    macbeth = Hurley.get("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml")
    @macbeth_hash = Hash.from_xml(macbeth.body)
  end

  def count_lines_by_speaker(scene)
    scene.inject(Hash.new(0)) do |counter, line|
      speaker = line["SPEAKER"].capitalize
      counter[speaker] += 1
      counter
    end
  end

end
