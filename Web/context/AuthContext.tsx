"use client";

import React, { createContext, useContext, useState, useEffect } from 'react';
import { useRouter, usePathname } from 'next/navigation';
import { api } from '@/lib/api';

interface AuthContextType {
    user: any | null;
    isAuthenticated: boolean;
    isLoading: boolean;
    login: (token: string, userData: any) => void;
    logout: () => void;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: React.ReactNode }) {
    const [user, setUser] = useState<any | null>(null);
    const [isLoading, setIsLoading] = useState(true);
    const router = useRouter();
    const pathname = usePathname();

    const checkAuth = () => {
        const token = localStorage.getItem('admin_token');
        const userData = localStorage.getItem('admin_user');

        if (token && userData) {
            setUser(JSON.parse(userData));
        } else {
            setUser(null);
        }
        setIsLoading(false);
    };

    useEffect(() => {
        checkAuth();

        // Listen for 401 errors from the API
        const handleUnauthorized = () => {
            logout();
        };

        // Attach the listener to our API client (we'll implement this next)
        (api as any).onUnauthorized = handleUnauthorized;

        return () => {
            (api as any).onUnauthorized = null;
        };
    }, []);

    const login = (token: string, userData: any) => {
        localStorage.setItem('admin_token', token);
        localStorage.setItem('admin_user', JSON.stringify(userData));
        setUser(userData);
        router.push('/dashboard');
    };

    const logout = () => {
        localStorage.removeItem('admin_token');
        localStorage.removeItem('admin_user');
        setUser(null);
        router.push('/');
    };

    return (
        <AuthContext.Provider value={{ user, isAuthenticated: !!user, isLoading, login, logout }}>
            {children}
        </AuthContext.Provider>
    );
}

export function useAuth() {
    const context = useContext(AuthContext);
    if (context === undefined) {
        throw new Error('Hook useAuth phải được sử dụng trong AuthProvider');
    }
    return context;
}
