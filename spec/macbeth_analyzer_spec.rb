require 'macbeth_analyzer'

RSpec.describe MacbethAnalyzer do

  before do
    @scene = [{"SPEAKER"=>"MACBETH", "LINE"=>["the first line"]},
              {"SPEAKER"=>"MACDUFF", "LINE"=>["the second line"]},
              {"SPEAKER"=>"MACBETH", "LINE"=>["the third line"]},
              {"SPEAKER"=>"MACDUFF", "LINE"=>["the fourth line"]}]

    @act = [{"SCENE"=>@scene},
            {"SCENE"=>@scene}]

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
  end

  describe "#count_lines_in_act" do
    context "given an act with multiple scenes" do
      it "counts the numbers of lines per speaker" do
        analyzer = MacbethAnalyzer.new
        lines_by_speaker = analyzer.count_lines_in_act(@act)

        expect(lines_by_speaker).to eq({ "Macbeth" => 4,
                                         "Macduff" => 4 })
      end
    end
  end
end
