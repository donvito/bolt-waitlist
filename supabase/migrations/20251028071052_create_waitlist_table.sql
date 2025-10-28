/*
  # Create Waitlist Table

  1. New Tables
    - `waitlist`
      - `id` (uuid, primary key) - Unique identifier for each entry
      - `email` (text, unique, not null) - Email address of the subscriber
      - `created_at` (timestamptz) - Timestamp when the email was added
  
  2. Security
    - Enable RLS on `waitlist` table
    - Add policy for anonymous users to insert their own email
    - Add policy for authenticated users to read all waitlist entries (for admin purposes)
  
  3. Notes
    - Email must be unique to prevent duplicate signups
    - Table is optimized for fast inserts
*/

CREATE TABLE IF NOT EXISTS waitlist (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  email text UNIQUE NOT NULL,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE waitlist ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can add their email to waitlist"
  ON waitlist
  FOR INSERT
  TO anon
  WITH CHECK (true);

CREATE POLICY "Authenticated users can view waitlist"
  ON waitlist
  FOR SELECT
  TO authenticated
  USING (true);