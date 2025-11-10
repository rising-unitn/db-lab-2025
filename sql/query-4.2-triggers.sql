CREATE OR REPLACE FUNCTION artist_not_manager() RETURNS TRIGGER AS $$
BEGIN
  IF EXISTS (SELECT 1 FROM Artists WHERE artist_id = NEW.manager_id) THEN
    RAISE EXCEPTION 'An artist cannot be a manager';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_artist_not_manager
BEFORE INSERT OR UPDATE ON Managers
FOR EACH ROW EXECUTE FUNCTION artist_not_manager();

CREATE OR REPLACE FUNCTION manager_not_artist() RETURNS TRIGGER AS $$
BEGIN
  IF EXISTS (SELECT 1 FROM Managers WHERE manager_id = NEW.artist_id) THEN
    RAISE EXCEPTION 'A manager cannot be an artist';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_manager_not_artist
BEFORE INSERT OR UPDATE ON Artists
FOR EACH ROW EXECUTE FUNCTION manager_not_artist();

CREATE OR REPLACE FUNCTION check_at_least_one_song() RETURNS TRIGGER AS $$
BEGIN
 IF (SELECT COUNT(*) FROM Songs WHERE album_id = NEW.album_id) < 2 THEN
    RAISE EXCEPTION 'Each album must have more one than song. Use a single statement when inserting songs';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_at_least_one_song
AFTER INSERT OR UPDATE ON Songs
FOR EACH ROW EXECUTE FUNCTION check_at_least_one_song();
