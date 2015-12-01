require 'hurley'
require 'pry'
require 'active_support/core_ext/hash'

class MacbethAnalyzer

  attr_reader :macbeth_hash

  def count_lines_in_play(play)
    play["ACT"].inject(Hash.new(0)) do |counter, act|
      count_lines_in_act(act, counter)
    end
  end

  def count_lines_in_act(act, counter = Hash.new(0) )
    act.inject(counter) do |counter, scene|
      count_lines_in_scene(scene["SCENE"], counter)
    end
  end

  def count_lines_in_scene(scene, counter = Hash.new(0) )
    scene["SPEECH"].inject(counter) do |counter, line|
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
