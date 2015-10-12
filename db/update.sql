ALTER TABLE bands_members RENAME TO concerts_members;
ALTER TABLE concerts_members DROP FOREIGN KEY concerts_members_ibfk_1;
ALTER TABLE concerts_members DROP KEY band_id;
ALTER TABLE concerts_members CHANGE COLUMN band_id concert_id int NOT NULL;
ALTER TABLE concerts_members ADD FOREIGN KEY(concert_id) REFERENCES concerts(id) ON DELETE CASCADE;

