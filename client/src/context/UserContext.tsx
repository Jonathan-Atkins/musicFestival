import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useMemo,
  useState,
  ReactNode,
} from 'react';

const API_BASE_URL = 'http://localhost:3000/api/v1';

type User = {
  id: string;
  first_name: string;
  last_name: string;
  email: string;
  username: string;
  birthday: string;
  schedule_id: number | null;
};

type UserContextValue = {
  user: User | null;
  loading: boolean;
  login: (email: string) => Promise<User>;
  logout: () => Promise<void>;
};

const UserContext = createContext<UserContextValue | undefined>(undefined);

async function fetchJson<T>(input: RequestInfo, init?: RequestInit): Promise<T> {
  const response = await fetch(input, {
    ...init,
    credentials: 'include',
    headers: {
      'Content-Type': 'application/json',
      ...(init?.headers ?? {}),
    },
  });

  if (!response.ok) {
    const errorBody = await response.json().catch(() => ({}));
    const message = (errorBody as { error?: string }).error ?? response.statusText;
    throw new Error(message || 'Request failed');
  }

  return response.json() as Promise<T>;
}

async function getCurrentUser(): Promise<User | null> {
  try {
    const payload = await fetchJson<{ data: { id: string; attributes: User } }>(`${API_BASE_URL}/me`);
    const { id, attributes } = payload.data;
    return { ...attributes, id };
  } catch (error) {
    return null;
  }
}

async function findUserByEmail(email: string): Promise<User> {
  const payload = await fetchJson<{ data: { id: string; attributes: User } }>(
    `${API_BASE_URL}/users/find?email=${encodeURIComponent(email)}`
  );

  const { id, attributes } = payload.data;
  return { ...attributes, id };
}

async function destroySession(): Promise<void> {
  const response = await fetch(`${API_BASE_URL}/logout`, {
    method: 'DELETE',
    credentials: 'include',
  });

  if (!response.ok) {
    throw new Error('Failed to logout');
  }
}

export const UserProvider = ({ children }: { children: ReactNode }) => {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    let isMounted = true;

    getCurrentUser()
      .then((currentUser) => {
        if (isMounted) {
          setUser(currentUser);
        }
      })
      .finally(() => {
        if (isMounted) {
          setLoading(false);
        }
      });

    return () => {
      isMounted = false;
    };
  }, []);

  const login = useCallback(async (email: string) => {
    const foundUser = await findUserByEmail(email);
    setUser(foundUser);
    return foundUser;
  }, []);

  const logout = useCallback(async () => {
    await destroySession();
    setUser(null);
  }, []);

  const value = useMemo(
    () => ({
      user,
      loading,
      login,
      logout,
    }),
    [user, loading, login, logout]
  );

  return <UserContext.Provider value={value}>{children}</UserContext.Provider>;
};

export const useUser = (): UserContextValue => {
  const context = useContext(UserContext);
  if (!context) {
    throw new Error('useUser must be used within a UserProvider');
  }
  return context;
};
