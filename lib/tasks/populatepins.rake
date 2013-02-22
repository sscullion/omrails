namespace :db do
	desc "Fill database with sample pins"
	task populate: :environment do
		User.all.each do |user|
			puts "[DEBUG] uploading images for user #{user.id} of #{User.last.id}"
			50.times do |n|
				image = File.open(Dir.glob(File.join(Rails.root, 'sample_images', '*')).sample)
				description = %w(cool awesome crazy wow adorbs incredible beautiful nice tasty sexy).sample
				user.pins.create!(image: image,
				description: description)
			end
		end
	end
end