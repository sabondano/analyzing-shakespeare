require 'macbeth_analyzer'

RSpec.describe MacbethAnalyzer do

  before do
    @two_speakers_per_line_scene = { "SPEECH" =>
                                    [ {"SPEAKER" => ["MACBETH", "MACDUFF"],
                                       "LINE"    => ["the first line"]} ] }

    @scene = { "SPEECH"=>[ {"SPEAKER"=>"MACBETH", "LINE"=>["the first line"] },
                           {"SPEAKER"=>"MACDUFF", "LINE"=>["the second line"]},
                           {"SPEAKER"=>"MACBETH", "LINE"=>["the third line"] },
                           {"SPEAKER"=>"MACDUFF", "LINE"=>["the fourth line"]} ] }

    @act = {"SCENE"=>[@scene, @scene]}

    @play = {"ACT"=>[@act, @act]}
  end

  describe "#count_lines_in_scene" do
    context "given a scene" do
      it "counts the number of lines per speaker" do
        analyzer = MacbethAnalyzer.new
        lines_by_speaker = analyzer.count_lines_in_scene(@scene)

        expect(lines_by_speaker).to eq({ "Macbeth" => 2,
                                         "Macduff" => 2 })
      end
    end

    context "given a scene with two speakers saying the same line" do
      it "attributes the line to both speakers" do
        analyzer = MacbethAnalyzer.new
        lines_by_speaker = analyzer.count_lines_in_scene(@two_speakers_per_line_scene)

        expect(lines_by_speaker).to eq({ "Macbeth" => 1,
                                         "Macduff" => 1 })
      end
    end
  end

  describe "#count_lines_in_act" do
    context "given an act with multiple scenes" do
      it "counts the number of lines per speaker" do
        analyzer = MacbethAnalyzer.new
        lines_by_speaker = analyzer.count_lines_in_act(@act)

        expect(lines_by_speaker).to eq({ "Macbeth" => 4,
                                         "Macduff" => 4 })
      end
    end
  end

  describe "#count_lines_in_play" do
    context "given a play with multiple acts" do
      it "counts the number of lines per speaker" do
        analyzer = MacbethAnalyzer.new
        lines_by_speaker = analyzer.count_lines_in_play(@play)

        expect(lines_by_speaker).to eq({ "Macbeth" => 8,
                                         "Macduff" => 8 })
      end
    end
  end 
end
