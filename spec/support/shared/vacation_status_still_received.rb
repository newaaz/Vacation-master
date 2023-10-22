shared_examples_for 'Vacation status still: received' do
  it 'not changed vacation status' do
    expect(vacation.status).to eq 'received'
  end
end

