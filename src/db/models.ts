export interface User {
  id: number;
  username: string;
  email: string;
  created_at: string;
  password_hash: string;
}

export interface Post {
  id: number;
  author_id: number;
  title: string;
  content: string;
  status: string;
  published_at: string;
  created_at: string;
  updated_at: string;
}

export interface PostCreate {
  title: string;
  content: string;
  author_id: number;
  status: string;
}
