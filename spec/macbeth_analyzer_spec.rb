require 'macbeth_analyzer'

RSpec.describe MacbethAnalyzer, "#count_lines_by_speaker" do
  it "counts the number of lines per speaker in a scene" do
    scene = [{"SPEAKER"=>"MACBETH", "LINE"=>["the first line"]},
             {"SPEAKER"=>"MACDUFF", "LINE"=>"the second line"},
             {"SPEAKER"=>"MACBETH", "LINE"=>["the third line"]},
             {"SPEAKER"=>"MACDUFF", "LINE"=>["the fourth line"]}]

    analyzer = MacbethAnalyzer.new
    lines_by_speaker = analyzer.count_lines_by_speaker(scene)

    expect(lines_by_speaker).to eq({ "Macbeth" => 2,
                                     "Macduff" => 2 })
  end
end
