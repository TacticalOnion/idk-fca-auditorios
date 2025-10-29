export type Modality = 'Online' | 'Presencial'
export type Status = 'Pendiente' | 'Autorizado' | 'Cancelado'


export interface EquipmentItem { name: string; quantity: number }
export interface Person { name: string; email?: string; profileUrl?: string; semblanzaUrl?: string }


export interface EventItem {
    id: string;
    name: string;
    megaEvent: string;
    venue: string;
    status: Status;
    startDate: string; // ISO date
    endDate: string; // ISO date
    startTime: string; // HH:mm
    endTime: string; // HH:mm
    modalities: Modality[];
    category: string;
    requestedAt: string; // ISO date
    description: string;
    cancelReason?: string;
    organizers: Person[];
    participants: Person[];
    equipment: EquipmentItem[];
    areas: string[];
}