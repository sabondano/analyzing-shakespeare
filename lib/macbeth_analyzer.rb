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
    act["SCENE"].inject(counter) do |counter, scene|
      count_lines_in_scene(scene, counter)
    end
  end

  def count_lines_in_scene(scene, counter = Hash.new(0) )
    scene["SPEECH"].inject(counter) do |counter, line|
      if line["SPEAKER"].class == Array
        line["SPEAKER"].each do |speaker|
          speaker = speaker.capitalize
          counter[speaker] += 1
        end
      else
        speaker = line["SPEAKER"].capitalize
        counter[speaker] += 1 unless speaker == "All"
      end
      counter
    end
  end

  def print_report
    build_report.each do |speaker, number_of_lines|
      puts "#{number_of_lines} #{speaker}"
    end
  end

  def build_report
    fetch_macbeth
    count_lines_in_play(@macbeth_hash).sort_by do |speaker, number_of_lines|
      number_of_lines
    end.reverse
  end

  def fetch_macbeth
    macbeth = Hurley.get("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml")
    @macbeth_hash = Hash.from_xml(macbeth.body)["PLAY"]
  end

end
